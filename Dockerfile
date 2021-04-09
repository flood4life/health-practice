FROM ruby:3.0.0

RUN apt-get update -qq && apt-get install -y nodejs

WORKDIR /app

COPY Gemfile Gemfile.lock ./
COPY bin/ ./bin

RUN bin/bundle config set --local deployment 'true'
RUN bin/bundle install --jobs 5 --retry 3

COPY . /app

ENTRYPOINT [ "./entrypoint.sh" ]
CMD [ "web-server" ]
