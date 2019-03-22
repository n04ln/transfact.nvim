package main

import (
	"io/ioutil"
	"net/http"
	"net/url"

	"github.com/NoahOrberg/nimvle.nvim/nimvle"
	"github.com/kelseyhightower/envconfig"
	"github.com/neovim/go-client/nvim"
	"github.com/neovim/go-client/nvim/plugin"
)

type Config struct {
	AppURL string `default:""`
}

var c Config

func main() {

	plugin.Main(
		func(p *plugin.Plugin) error {
			p.HandleFunction(
				&plugin.FunctionOptions{Name: "InitializeTransfact"},
				// Setting from env variable.
				func(v *nvim.Nvim, args []string) (string, error) {
					nimvle := nimvle.New(v, "transfact")
					err := envconfig.Process("TRANSFACT", &c)
					if err != nil {
						nimvle.Log(err)
						panic(err) // failed initialize
					}

					return "", nil
				})
			p.HandleFunction(
				&plugin.FunctionOptions{Name: "Trans"},
				// Translate args string.
				func(v *nvim.Nvim, args []string) (string, error) {
					nimvle := nimvle.New(v, "transfact")
					if len(args) != 1 {
						nimvle.Log("args length is not 1")
						return "", nil
					}
					if c.AppURL == "" {
						nimvle.Log("URL is not specified")
						return "", nil
					}

					text, err := translate(nimvle, args[0])
					if err != nil {
						nimvle.Log(err)
						return "", nil
					}

					return text, nil
				})
			return nil
		})
}

func translate(nimvle *nimvle.Nimvle, text string) (string, error) {
	client := http.DefaultClient

	u, err := url.Parse(c.AppURL)
	if err != nil {
		return "", err
	}
	q := u.Query()
	q.Set("text", text)
	q.Set("source", "en")
	q.Set("target", "ja")
	u.RawQuery = q.Encode()
	nimvle.Log(u.RawQuery)

	req, err := http.NewRequest("GET", u.String(), nil)
	if err != nil {
		return "", err
	}
	res, err := client.Do(req)
	if err != nil {
		return "", err
	}

	traslatedText, err := ioutil.ReadAll(res.Body)
	if err != nil {
		return "", err
	}

	return string(traslatedText), nil
}
