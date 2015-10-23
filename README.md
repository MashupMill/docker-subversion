Dockerfile for Subversion
===

SVN Server supported by apache

## Usage with boot2docker

```sh
docker pull mashupmill/subversion
docker run -d --name=svn-repo -p 80:80 \
    --env COMPATIBLE_VERSION=1.6 \
    --env USERNAME=my-user --env PASSWORD=my-generated-password \
    mashupmill/subversion
cd your/work/dir
svn co http://$(boot2docker ip)/ repo
```
