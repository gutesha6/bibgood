FROM ruby:2.3
MAINTAINER Oleg Borys <addicted2sounds@gmail.com>
RUN apt-get update && apt-get install -y \
  build-essential nodejs-legacy npm vim && \
  npm install -g phantomjs-prebuilt
RUN mkdir -p /app/user
# RUN mkdir -p /bundle
WORKDIR /app/user
COPY Gemfile Gemfile.lock ./
# ENV PATH /app/user/bin:/bundle/bin:$PATH
# ENV GEM_PATH /bundle
# ENV GEM_HOME /bundle
ENV BUNDLE_PATH /bundle
# RUN gem install bundler --no-ri --no-rdoc
# RUN bundle check || bundle install  --path /bundle --jobs 2 --retry 5
ADD . /app/user
# ENTRYPOINT ["bundle", "exec"]
CMD ["rails", "server", "-b", "0.0.0.0", "-p", "8080"]
