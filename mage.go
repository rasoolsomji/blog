//+build mage

package main

import (
	"github.com/magefile/mage/mg"
	"github.com/magefile/mage/sh"
	"github.com/magefile/mage/target"
)

var sourceDirs = []string{
	"archetypes/",
	"content/",
	"resources/",
	"static/",
	"themes/",
}

// Lint the markdown source
func Lint() error {
	return sh.Run("markdownlint", "content", "archetypes")
}

// Build the project
func Build() error {
	isChanged, err := target.Dir("public/", sourceDirs...)
	if err != nil {
		return err
	}
	if !isChanged {
		return nil
	}
	return sh.Run("hugo", "-v")
}

// Start the debug server for blog development
func Serve() error {
	// Serve drafts
	return sh.Run("hugo", "server", "-D")
}

func Proof() error {
	// We require the build output for linting html
	mg.Deps(Build)
	// Proofread the generated HTML
	return sh.Run("htmlproofer", "./public", "--allow-hash-href", "--check-html")
}
