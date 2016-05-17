From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Tue, 17 May 2016 15:44:34 -0700
Subject: [Cocci] compiling latest coccinelle on opensuse
In-Reply-To: <alpine.DEB.2.02.1605172250560.2064@localhost6.localdomain6>
References: <CAB=NE6X4mqH+Vj41bba4e7y7vYKqhpsC5dqHUZLrmDKtA1XVwA@mail.gmail.com>
 <alpine.DEB.2.02.1605172250560.2064@localhost6.localdomain6>
Message-ID: <CAB=NE6V=aqW8VC4OML6vc+hJHkbcfH3dBzo==3uVRAuZK8Mv6A@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Tue, May 17, 2016 at 1:52 PM, Julia Lawall <julia.lawall@lip6.fr> wrote:
> On Tue, 17 May 2016, Luis R. Rodriguez wrote:
>> Its my understanding that if I don't have parser_cocci_menhir.ml then
>> I need menhir -- but I also was under the impression that menhir would
>> not be required for github users? Can someone confirm?
>
> Once you do make distclean, you need to have menhir installed.  But I
> think that if you do a git checkout -- . you would return to a viable
> state.

Thanks, I tried 'git checkout -f' after 'git clean -f -x -d' and prior
to moving forward made sure to rm -rf menhir. I ended up in the same
place with github:

make[2]: Entering directory '/sda3/home/mcgrof/devel/coccinelle/parsing_cocci'
/usr/bin/ocamllex.opt lexer_cocci.mll
/usr/bin/ocamllex.opt lexer_cli.mll
/usr/bin/ocamllex.opt lexer_script.mll
/home/mcgrof/devel/coccinelle/setup/fake-menhir.sh menhir --ocamlc
"/usr/bin/ocamlc.opt" --ocamldep "/usr/bin/ocamldep" --table --base
parser_cocci_menhir parser_cocci_menhir.mly
error: the file parser_cocci_menhir.ml is needed, which requires
preprocessing by menhir to obtain it from parser_cocci_menhir.mly.
However, menhir is not enabled.

  Luis
