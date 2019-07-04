FROM donwb/elixir:0.3
MAINTAINER Don Browning

# Make sure mix is good
RUN mix local.rebar
RUN mix local.hex --force

## Install the app ##

# We assume the deps have already been fetched
ADD . /opt/hackathon


## Compile ##

# It is important to set MIX_ENV *before* compiling the code
ENV MIX_ENV dev

WORKDIR /opt/hackathon

# Compile and build the release
RUN mix deps.get
RUN mix compile
RUN mix release

## Running environment ##

ENV PORT 3000
EXPOSE 3000


# This shouldn't be the way to do it, but it keeps the container running
# Unfortunately it *is* getting in the way of `eb` working
# some kind of erlang race condition w/the console
#CMD ["iex", "-S", "mix"]
CMD ["/bin/bash", "run.sh"]

# Still can't keep container running using exrm 
# CMD ["/opt/siteholder/rel/siteholder/bin/siteholder", "start"]




