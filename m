From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 6 Aug 2016 09:14:25 +0200 (CEST)
Subject: [Cocci] Bad formatting when changing function prototypes
In-Reply-To: <CANr=Z=Zeg_fO7m9uDzK1HgV3i0QuQNt5dppr+mggRZ1sjXE8Bw@mail.gmail.com>
References: <CANr=Z=bpk1DKiXODccy8Ru0QkP8EX0_v6BfVA2PvsOZ9gpiVXw@mail.gmail.com>
 <alpine.DEB.2.10.1608052249480.3315@hadrien>
 <CANr=Z=Zeg_fO7m9uDzK1HgV3i0QuQNt5dppr+mggRZ1sjXE8Bw@mail.gmail.com>
Message-ID: <alpine.DEB.2.10.1608060913160.3433@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Fri, 5 Aug 2016, Joe Hershberger wrote:

> Hi Julia,
>
> On Fri, Aug 5, 2016 at 3:52 PM, Julia Lawall <julia.lawall@lip6.fr> wrote:
> > On Fri, 5 Aug 2016, Joe Hershberger wrote:
> >
> >> Hi,
> >>
> >> I'm trying to use spatch to convert from one API to another across
> >> many files and I'm running into a problem.
> >>
> >> I don't know if I'm not configuring a setting properly or if it might be a bug.
> >>
> >> Here's what I'm seeing... function prototypes or definitions that are
> >> near or over the 80 char limit end up with poor formatting.
> >>
> >> https://patchwork.ozlabs.org/patch/605756/
> >>
> >> Eg:
> >>
> >> -static int bfin_miiphy_read(const char *devname, uchar addr, uchar
> >> reg, ushort *val)
> >> +static int bfin_miiphy_read(struct mii_dev *bus, int addr, int devad, int reg
> >> +       )
> >>
> >> -static int bfin_miiphy_write(const char *devname, uchar addr, uchar
> >> reg, ushort val)
> >> +static int bfin_miiphy_write(struct mii_dev *bus, int addr, int devad,
> >> +                            int reg, u16 val
> >> +       )
> >>
> >> -static int davinci_mii_phy_read(const char *devname, unsigned char
> >> addr, unsigned char reg, unsigned short *value)
> >> +static int davinci_mii_phy_read(struct mii_dev *bus, int addr, int devad,
> >> +       int reg
> >> +       )
> >>
> >> The worst part is that it moves the close paren to the next line.
> >>
> >> Also, I'm not sure how it decides how much indentation to use if it
> >> truly needs an extra line for parameters. Ideally the indentation of
> >> the next line of parameters would match the open paren position. It
> >> seems to do that in some cases and not in other cases. I'm not sure
> >> what affects it.
> >>
> >> I had started back when 1.0.4 was the most recent, and I just now
> >> tested with both 1.0.5 and master. All behave identically.
> >>
> >> Does anyone have an idea what I can do to affect this behavior or does
> >> it require a code change?
> >
> > Could you send a semantic patch that causes the problem?
>
> Here is the patch that I'm using.  https://patchwork.ozlabs.org/patch/605758/
>
> It is intended to apply to http://git.denx.de/?p=u-boot.git;a=summary
>
> I've been executing spatch using this command line within the U-Boot
> source tree:
>
> spatch --in-place --sp-file scripts/coccinelle/net/mdio_register.cocci .
>
> > For function calls, there is an effort to stay within 80 characters, and
> > to put the extra lines just after the (.  I would have to look into why it
> > is not doing this for function declarations.  I don't think there is
> > anything you can do on your side.
>
> OK, good to know. If there is anything I can do to make it easier to
> reproduce, please let me know.

I have the impression that if you don't put a newline in front of the
added ) then Coccinelle also does not put one.  I don't yet know why it
behaves this way, though.

julia
