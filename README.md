## Status Quo [![Code Climate](https://codeclimate.com/github/solid5nake/status-quo/badges/gpa.svg)](https://codeclimate.com/github/solid5nake/status-quo) [![Travis CI](https://travis-ci.org/solid5nake/status-quo.svg)](https://travis-ci.org/solid5nake/status-quo)

Monitor the status of your application. Send alerts and visualize the application status over time

### Usage

```ruby
StatusQuo.watch :social_media do

  segment :facebook do
    schedule "30 9 * * *"
    confirm do
      `curl -sL -w "%{http_code}" "http://facebook.com" -o /dev/null` == "200"
    end
  end

  segment :twitter do
    schedule "30 9 * * *"
    confirm do
      `curl -sL -w "%{http_code}" "http://twitter.com" -o /dev/null` == "200"
    end
  end

  segment :instagram do
    schedule "30 9 * * *"
    confirm do
      `curl -sL -w "%{http_code}" "http://instagram.com" -o /dev/null` == "200"
    end
  end

end
```

### License

Copyright (c) 2015 Bram Engel, released under the MIT License

http://github.com/solid5nake – engelenburg1980@gmail.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
