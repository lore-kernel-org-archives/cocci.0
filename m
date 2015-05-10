From: Sebastien.Hinderer@inria.fr (=?utf-8?Q?S=C3=A9bastien?= Hinderer)
Date: Sun, 10 May 2015 23:01:18 +0200
Subject: [Cocci] Installing Coccinelle 1.0.0 on Ubuntu 14.04
In-Reply-To: <CAOMZO5CayXd3Y2tPB3tqjd++fam=pt+yCZNbytpH8RCcobRifg@mail.gmail.com>
References: <CAOMZO5DOr4Nz4gKkvkVKak3puk_Savmt3YmuDdnctufmixoYgg@mail.gmail.com>
 <20150508231943.GA4321@pema>
 <CAOMZO5DW1LScRsJ4qbD9iTXV7psW_PnCAMKaNUfsesD7b51O1g@mail.gmail.com>
 <CAOMZO5CayXd3Y2tPB3tqjd++fam=pt+yCZNbytpH8RCcobRifg@mail.gmail.com>
Message-ID: <20150510210118.GA8542@pema>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Fabio Estevam (2015/05/08 21:23 -0300):
> On Fri, May 8, 2015 at 8:41 PM, Fabio Estevam <festevam@gmail.com> wrote:
> > Hi S?bastien,
> >
> > On Fri, May 8, 2015 at 8:19 PM, S?bastien Hinderer
> > <Sebastien.Hinderer@inria.fr> wrote:
> >
> >> Strange that the module is not found. What do you see related to regexp
> >> in the output o configure, please? If you are unsure, could you please
> >> send configure's output?
> >
> > In the output of ./configure I see only one reference to regexp:
> >
> > config.status: creating globals/regexp.ml
> >
> > If you would like to check the full output, please check:
> > http://pastebin.com/ACMD7gw0
> 
> Ok, got it build after installing the libpcre-ocaml-dev package.

Thanks. IT is true that coccinelle's current build system does not make a
good job at veryfing that the necessary development files are properly
installed.

S?bastien.
