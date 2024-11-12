# frozen_string_literal: true

# Pagy initializer file

# Instance variables
# See https://ddnexus.github.io/pagy/api/pagy#instance-variables
Pagy::DEFAULT[:limit] = 20

# Metadata extra: Provides the pagination metadata to Javascript frameworks like Vue.js, react.js, etc.
# See https://ddnexus.github.io/pagy/extras/metadata
# you must require the shared internal extra (BEFORE the metadata extra) ONLY if you need also the :sequels
require 'pagy/extras/headers'
require 'pagy/extras/metadata'
# For performance reasons, you should explicitly set ONLY the metadata you use in the frontend
Pagy::DEFAULT[:metadata] = %i[page prev next last from to]

# Trim extra: Remove the page=1 param from links
# See https://ddnexus.github.io/pagy/extras/trim
require 'pagy/extras/trim'
# set to false only if you want to make :trim_extra an opt-in variable
Pagy::DEFAULT[:trim_extra] = true

# When you are done setting your own default freeze it, so it will not get changed accidentally
Pagy::DEFAULT.freeze
