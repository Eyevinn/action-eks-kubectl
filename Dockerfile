FROM alpine:3.10.2
MAINTAINER Eyevinn Technology <work@eyevinn.se>

WORKDIR /usr/local/bin

RUN apk add --no-cache --update openssl curl ca-certificates && \
  curl -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.17.9/2020-08-04/bin/darwin/amd64/kubectl && \
  chmod +x ./kubectl && \
  rm -rf /var/cache/apk/*
RUN curl -o aws-iam-authenticator https://amazon-eks.s3.us-west-2.amazonaws.com/1.17.9/2020-08-04/bin/linux/amd64/aws-iam-authenticator && \
  chmod +x ./aws-iam-authenticator
RUN apk add --no-cache --update python3 && pip3 install awscli --upgrade

COPY entrypoint.sh entrypoint.sh
RUN chmod +x entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]
CMD ["cluster-info"]
