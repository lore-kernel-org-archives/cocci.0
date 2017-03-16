From: peter.senna@gmail.com (Peter Senna Tschudin)
Date: Thu, 16 Mar 2017 07:12:55 +0100
Subject: [Cocci] coccicheck run error
In-Reply-To: <20170315221442.GA13992@eros>
References: <20170315103555.GA27181@eros>
 <alpine.DEB.2.20.1703151200540.6227@hadrien>
 <20170315221054.GA13587@eros> <20170315221442.GA13992@eros>
Message-ID: <CA+MoWDqdp79Pr7TLh0raKTF+QtfZDrK+EUUJjuAxXLQarBPc1A@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, Mar 15, 2017 at 11:14 PM, Tobin C. Harding <me@tobin.cc> wrote:

[...]

> Oh, and also FYI
> $sudo apt-get install ocaml ocaml-findlib libpcre-ocaml-dev pkg-config libpcre-ocaml-dev

can you try

$ apt-get build-dep coccinelle

More information about needed packages:

http://packages.ubuntu.com/yakkety/coccinelle

[...]


-- 
Peter
