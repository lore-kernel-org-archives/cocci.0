From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 26 Jan 2017 16:31:59 +0100 (CET)
Subject: [Cocci] some questions related to output formatting
In-Reply-To: <EC57B573-1942-4118-A86D-9177BA76DFE3@linaro.org>
References: <FAB49815-C2ED-4463-94A6-A766A21C6F9B@linaro.org>
 <alpine.DEB.2.20.1701261516370.3109@hadrien>
 <EC57B573-1942-4118-A86D-9177BA76DFE3@linaro.org>
Message-ID: <alpine.DEB.2.20.1701261627420.3109@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

For parsing Zephyr, the main issue seems to be the __IO annotation.  You
can take the existing standard.h, copy it to eg zephyr.h and add

#define __IO

then when you run Coccinelle, put --macro-file-builtins zephyr.h

You should also be able to put at the root of the zephyr directory a file
.cocciconfig

[spatch]
options = --macro-file-builtins zephyr.h

Or rather the complete path for zephyr.h.  Then this file will always be
used when you run Coccinelle on code in the zephyr directory.

julia
