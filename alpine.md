## To test the basic functionality with an alpine docker image

Before creating our own image we can test the basic functionality as follow:

Under `/home/gdha/projects/pi4-temperature2graphite` directory run

```bash
gdha@n1:~$ docker run -it -v /usr/local/bin/kubectl:/usr/local/bin/kubectl -v /home:/home -v /etc/hostname:/etc/hostname alpine /bin/sh
```

and play around...
