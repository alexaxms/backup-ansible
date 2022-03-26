FROM archlinux:base 

RUN pacman -Sy --noconfirm sudo ansible git 
ARG TAGS
RUN groupadd --gid 1000 alexm
RUN useradd -m -g alexm --uid 1000 --gid 1000 -s /usr/bin/nologin alexm
RUN echo "alexm ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/alexm
USER alexm
WORKDIR /home/alexm

COPY --chown=alexm:alexm . .
CMD ["sh", "-c", "ansible-playbook $TAGS local.yaml"]
