From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 16 Mar 2017 13:27:54 +0100 (CET)
Subject: [Cocci] coccicheck run error
In-Reply-To: <20170316113300.GA22099@eros>
References: <20170315103555.GA27181@eros>
 <alpine.DEB.2.20.1703151200540.6227@hadrien> <20170315221054.GA13587@eros>
 <20170315221442.GA13992@eros>
 <CA+MoWDqdp79Pr7TLh0raKTF+QtfZDrK+EUUJjuAxXLQarBPc1A@mail.gmail.com>
 <20170316075157.GC27761@eros>
 <CA+MoWDoftRaa=bjK9=q=4L0bmR7WXY0Vwg7aoELhU8WPHjGnxA@mail.gmail.com>
 <20170316113300.GA22099@eros>
Message-ID: <alpine.DEB.2.20.1703161326580.3168@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Thu, 16 Mar 2017, Tobin C. Harding wrote:

> On Thu, Mar 16, 2017 at 09:16:21AM +0100, Peter Senna Tschudin wrote:
> > On Thu, Mar 16, 2017 at 8:51 AM, Tobin C. Harding <me@tobin.cc> wrote:
> > > On Thu, Mar 16, 2017 at 07:12:55AM +0100, Peter Senna Tschudin wrote:
> > >> On Wed, Mar 15, 2017 at 11:14 PM, Tobin C. Harding <me@tobin.cc> wrote:
> > >>
> > >> [...]
> > >>
> > >> > Oh, and also FYI
> > >> > $sudo apt-get install ocaml ocaml-findlib libpcre-ocaml-dev pkg-config libpcre-ocaml-dev
> > >>
> > >> can you try
> > >>
> > >> $ apt-get build-dep coccinelle
> > >
> > > I have coccinelle installed already. I'm trying to the latest version
> > > to build and install :)
> >
> > This suggestions is to install build dependencies, not Coccinelle itself.
>
> Wow, I did not know that apt-get command. Thank you for making the
> effort to email me the second time when you were clearly correct the
> first. Extremely well-natured of you, thank you.
>
> Coccinelle built! Pull request submitted on github to add the
> apt-get command to install.txt.

Great that it worked :)

But I guess that it is not a perfect solution, because the dependencies of
Coccinelle could change between what Ubuntu knows about and what is needed
in the latest version.

julia
