[![](http://www.squid-cache.org/Artwork/SubBanner.png)](http://www.squid-cache.org)

# Squid Proxy Server

Source code for:

- https://hub.docker.com/r/athlon1600/squid-proxy-server

## :rocket: Usage

Deploy this to a fresh Linux server by first installing Docker:

```shell
curl -fsSL https://get.docker.com | sudo sh
```

Then run either of the commands to deploy either a plain or a password-protected instance of Squid Proxy Server:

```shell
docker run --name proxy -d -p 3128:3128 athlon1600/squid-proxy-server
docker run --name proxy -d -p 3128:3128 -e "USERNAME=proxynova" -e "PASSWORD=password" athlon1600/squid-proxy-server
```

Test if it worked:

```shell
curl -x localhost:3128 https://checkip.amazonaws.com/
# or
curl -x localhost:3128 -U proxynova:password https://checkip.amazonaws.com/
```

## :construction: To-do list

- Make it so that it uses the latest Squid version 7.5 rather than the current version of 6.14
- Reduce image size as much as possible