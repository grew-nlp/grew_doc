+++
title = "docker"
menu = "main"
Categories = ["Development","GoLang"]
Tags = ["Development","golang"]
Description = ""
date = "2018-04-25T16:59:27+02:00"

+++

# Docker installation

Put the following code in a file called `Dockerfile`.
```
FROM ocaml/opam:ubuntu

RUN sudo apt-get update \
		&& sudo apt-get upgrade --assume-yes \
		&& sudo apt-get install python3-pip --assume-yes

RUN opam remote add talc "http://talc2.loria.fr/semagramme/opam" \
		&& opam install grew grewpy \
		&& pip3 install grew
```

Then, you can build the container with the command:

`docker build -t grew .`

And finally, run it with:

`docker run -it grew bash`

## Test

Inside the container (after the command `docker run -it grew bash`), run:

 * `python3`
 * `import grew`
 * `grew.init()`

You should have some output like:

```
connected to port: 8888
<subprocess.Popen object at 0x7ff507bc5208>
```

and **Grew** is ready to be used.
See [tutorial page](../tuto) for simple examples.
