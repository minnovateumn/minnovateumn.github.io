FROM alpine/bundle:2.7.1

ENV RUBY_VERSION=2.7.1

EXPOSE 4000

# ENV JEKYLL_ENV=production

COPY . /apps/minnovateumn

WORKDIR /apps/minnovateumn

RUN bundle install

CMD ["bundle", "exec", "jekyll", "serve", "--force_polling", "-H", "0.0.0.0", "-P", "4000"]