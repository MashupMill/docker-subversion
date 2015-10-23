Dockerfile for Subversion
===

The simplest subversion server by `svnserve`.

## Usage with boot2docker

```sh
docker pull mashupmill/subversion
docker run -d --name=svn-repo -p 3690:3690 \
    --env COMPATIBLE_VERSION=1.6 --env ANON_ACCESS=none \
    --env USERNAME=my-user --env PASSWORD=my-generated-password \
    mashupmill/subversion
cd your/work/dir
svn co svn://$(boot2docker ip)/ repo
```
