FROM ruby:2.7.2

LABEL maintainer="froala_git_travis_bot@idera.com"
ARG PackageName
ARG PackageVersion
ARG NexusUser
ARG NexusPassword
ARG GitUser
ARG GitToken

RUN apt-get update -y
RUN apt-get install -y --no-install-recommends nodejs yarn wget npm
RUN npm install -g git-credential-env
RUN git init && git config credential.helper "env --username=${GitUser} --password=${GitToken}"

COPY . /app
WORKDIR /app
RUN gem install bundler
RUN bundle install

RUN wget --no-check-certificate --user ${NexusUser}  --password ${NexusPassword} https://nexus.tools.froala-infra.com/repository/Froala-npm/${PackageName}/-/${PackageName}-${PackageVersion}.tgz
RUN tar -xvf ${PackageName}-${PackageVersion}.tgz

RUN cp -a package/css/. /usr/local/bundle/gems/wysiwyg-rails-*/app/assets/stylesheets/
RUN cp -a package/js/. /usr/local/bundle/gems/wysiwyg-rails-*/app/assets/javascripts/


EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
