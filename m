From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 8 May 2015 21:23:49 -0300
Subject: [Cocci] Installing Coccinelle 1.0.0 on Ubuntu 14.04
In-Reply-To: <CAOMZO5DW1LScRsJ4qbD9iTXV7psW_PnCAMKaNUfsesD7b51O1g@mail.gmail.com>
References: <CAOMZO5DOr4Nz4gKkvkVKak3puk_Savmt3YmuDdnctufmixoYgg@mail.gmail.com>
 <20150508231943.GA4321@pema>
 <CAOMZO5DW1LScRsJ4qbD9iTXV7psW_PnCAMKaNUfsesD7b51O1g@mail.gmail.com>
Message-ID: <CAOMZO5CayXd3Y2tPB3tqjd++fam=pt+yCZNbytpH8RCcobRifg@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Fri, May 8, 2015 at 8:41 PM, Fabio Estevam <festevam@gmail.com> wrote:
> Hi S?bastien,
>
> On Fri, May 8, 2015 at 8:19 PM, S?bastien Hinderer
> <Sebastien.Hinderer@inria.fr> wrote:
>
>> Strange that the module is not found. What do you see related to regexp
>> in the output o configure, please? If you are unsure, could you please
>> send configure's output?
>
> In the output of ./configure I see only one reference to regexp:
>
> config.status: creating globals/regexp.ml
>
> If you would like to check the full output, please check:
> http://pastebin.com/ACMD7gw0

Ok, got it build after installing the libpcre-ocaml-dev package.

Regards,

Fabio Estevam
