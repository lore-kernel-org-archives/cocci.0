From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 9 May 2015 06:55:44 +0200 (CEST)
Subject: [Cocci] Installing Coccinelle 1.0.0 on Ubuntu 14.04
In-Reply-To: <20150508231943.GA4321@pema>
References: <CAOMZO5DOr4Nz4gKkvkVKak3puk_Savmt3YmuDdnctufmixoYgg@mail.gmail.com>
 <20150508231943.GA4321@pema>
Message-ID: <alpine.DEB.2.02.1505090654060.2061@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sat, 9 May 2015, S?bastien Hinderer wrote:

> Hi Fabio,
> 
> 
> Fabio Estevam (2015/05/08 20:12 -0300):
> > File "./regexp_pcre.ml", line 22, characters 32-43:
> > Error: Unbound module Pcre
> 
> Strange that the module is not found. What do you see related to regexp
> in the output o configure, please? If you are unsure, could you please
> send configure's output?

It's a known problem.  For some reason, the configure mechanism doesn't 
work for Pcre.  Whether you select to have it or not, you have to have it.  
Just install it, and things will go better (this is not intended as the 
definitive solution, but we haven't had time to work on it).

julia
