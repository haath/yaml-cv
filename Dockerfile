
FROM ruby:2.6

LABEL maintainer="gmantaos@gmail.com"

ARG BUILD_TAG=v0.1.0

COPY Gemfile /src
COPY Gemfile.lock /src

RUN cd /src && \
    bundle install

COPY . /src

RUN gem build yaml-cv.gemspec --output=yaml-cv.gem && \
    gem install yaml-cv.gem && \
    rm -rf /src

CMD [ "yaml-cv" ]
