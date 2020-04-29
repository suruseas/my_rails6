ARG RUBY_VERSION
FROM ruby:${RUBY_VERSION}

ARG GEM_VERSION
ARG BUNDLER_VERSION

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - &&\
    echo 'deb https://dl.yarnpkg.com/debian/ stable main' > /etc/apt/sources.list.d/yarn.list &&\
    apt-get update -qq &&\
    apt-get install -yq --no-install-recommends \
    build-essential\
    nodejs\
    yarn\
    git\
    curl\
    vim &&\
    apt-get clean &&\
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* &&\
    truncate -s 0 /var/log/*log

RUN mkdir -p /app

ENV LANG=C.UTF-8\
    GEM_HOME=/bundle\
    BUNDLE_JOBS=4\
    BUNDLE_RETRY=3

ENV BUNDLE_PATH ${GEM_HOME}
ENV BUNDLE_APP_CONFIG=${BUNDLE_PATH}\
    BUNDLE_BIN=${BUNDLE_PATH}/bin
ENV PATH /app/bin:${BUNDLE_BIN}:$PATH

RUN gem update --system ${GEM_VERSION} &&\
    gem install bundler:${BUNDLER_VERSION}

COPY Gemfile Gemfile.lock /app/
WORKDIR /app

RUN bundle