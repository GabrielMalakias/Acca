# Timeline

A really simple log agregator (prints on STDOUT) based on Elixir.Plug

```shell
docker container run --publish 4001:4001 --detach --name timeline timeline:1

docker logs -f <container-id>

curl -X POST localhost:4001 -H "Content-Type: application/json" --data '{"data":"test"}'
```
