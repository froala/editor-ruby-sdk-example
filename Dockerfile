FROM ruby:2.7.2

LABEL maintainer="ganga@celestialsys.com"
ARG PackageName=froala-editor-QA241122
ARG PackageVersion=4.0.16
ARG NexusUser=froala-cid
ARG NexusPassword=tyl1pOcjsXGBCUDeh_iXsO7WLPK7LnEr3Ehn4JCz
ARG GitUser=froala-travis-bot
ARG GitToken=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

RUN apt-get update -y
RUN apt-get install -y --no-install-recommends nodejs yarn wget npm
RUN npm install -g git-credential-env
RUN git init && git config credential.helper "env --username=${GitUser} --password=${GitToken}"

COPY . /app
WORKDIR /app
RUN gem update --system
RUN gem install bundler
RUN bundle install


RUN wget --no-check-certificate --user ${NexusUser}  --password ${NexusPassword} https://nexus.tools.froala-infra.com/repository/Froala-npm/${PackageName}/-/${PackageName}-${PackageVersion}.tgz
RUN tar -xvf ${PackageName}-${PackageVersion}.tgz

RUN cp -a package/css/. /usr/local/bundle/gems/wysiwyg-rails-*/app/assets/stylesheets/
RUN cp -a package/js/. /usr/local/bundle/gems/wysiwyg-rails-*/app/assets/javascripts/
RUN rm -rf package/ ${PackageName}-${PackageVersion}.tgz

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]

