# Docker Image for ShadowsocksR

Docker image: [`arieshout/shadowsocksr`](https://hub.docker.com/r/arieshout/shadowsocksr/)

## Usage

```sh
docker run -d -e SS_PASSWORD=<your-password> -p 443:443 arieshout/shadowsocksr
```

This will start an SSR server which listens to port `443`, with the password set to `<your-password>` 
(change this in the command line), and with the following defaults:

* SS crypto method: `aes-256-cfb`
* SSR protocol: `auth_aes128_sha1`
* SSR obfuscation: `tls1.2_ticket_auth`

## Supported Configuration

Pass in the configuration as [Docker environment variables](https://docs.docker.com/engine/reference/run/#env-environment-variables), in the format

```sh
-e VARIABLE_NAME=some_value
```

The supported variables are

| Variable | Default Value | Description |
| --- | --- | --- |
| `SS_HOST` | `0.0.0.0` | The container's IP that the service listens on. As we are running in Docker container, it should be unnecessary to update this. |
| `SS_PORT` | `443` | The SS service port that the container exposes. This is the container port. To make it publicly accessible, use the `-p $PUBLIC_PORT:443` argument for the docker command. |
| `SS_METHOD` | `aes-256-cfb` | The cryptography method for the SS server. |
| `SS_PASSWORD` | *none* | The password for the SS server. **You should always specify this variable.** |
| `SSR_PROTOCOL` | `auth_aes128_sha1` | The SSR protocol plugin to be used. |
| `SSR_OBFS` | `tls1.2_ticket_auth` | The SSR obfuscation plugin to be used. |

These environment variables will be picked up in the `entrypoint.sh` file and fed to the server process.

## Extra Arguments

If you want to pass other arguments to the server process, such as `--fast-open`, just add them after the image name in the docker command:

```sh
docker run -d -e SS_PASSWORD=your-password -p 443:443 arieshout/shadowsocksr --fast-open
```

## Auto-start

To start the container automatically after reboot, or any other error, use the [`--restart`](https://docs.docker.com/engine/reference/run/#restart-policies-restart) argument:

```sh
docker run -d --restart unless-stopped -e SS_PASSWORD=your-password -p 443:443 arieshout/shadowsocksr
```