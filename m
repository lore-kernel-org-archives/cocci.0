From: Sebastien.Hinderer@inria.fr (=?utf-8?Q?S=C3=A9bastien?= Hinderer)
Date: Sat, 9 May 2015 01:19:43 +0200
Subject: [Cocci] Installing Coccinelle 1.0.0 on Ubuntu 14.04
In-Reply-To: <CAOMZO5DOr4Nz4gKkvkVKak3puk_Savmt3YmuDdnctufmixoYgg@mail.gmail.com>
References: <CAOMZO5DOr4Nz4gKkvkVKak3puk_Savmt3YmuDdnctufmixoYgg@mail.gmail.com>
Message-ID: <20150508231943.GA4321@pema>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi Fabio,


Fabio Estevam (2015/05/08 20:12 -0300):
> File "./regexp_pcre.ml", line 22, characters 32-43:
> Error: Unbound module Pcre

Strange that the module is not found. What do you see related to regexp
in the output o configure, please? If you are unsure, could you please
send configure's output?

S?bastien.
