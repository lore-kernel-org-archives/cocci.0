From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 3 Jan 2018 13:02:40 +0100 (CET)
Subject: [Cocci] [PATCH] Coccinelle: Rename the script for a
 transformation of memory allocations
In-Reply-To: <6423882b-20df-61fd-d7c6-ac1bb4ec891d@users.sourceforge.net>
References: <CAK7LNAR27r4j4c1FCh_ObpMpBKXgSP6Vq3P=reA-JKoTji6Q1A@mail.gmail.com>
 <ae67a02e-7257-c7e0-f4a1-bdf35a3bb2d0@users.sourceforge.net>
 <alpine.DEB.2.20.1801021528160.24055@hadrien>
 <6423882b-20df-61fd-d7c6-ac1bb4ec891d@users.sourceforge.net>
Message-ID: <alpine.DEB.2.20.1801031301470.3229@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Wed, 3 Jan 2018, SF Markus Elfring wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 3 Jan 2018 12:43:45 +0100
>
> A script for the semantic patch language was extended
> in a significant way.
> An other file name is more appropriate then to indicate
> the provided functionality. Thus rename this file.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  ...kzalloc-simple.cocci => use zalloc functions with extra changes.cocci} | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  rename scripts/coccinelle/api/alloc/{kzalloc-simple.cocci => use zalloc functions with extra changes.cocci} (100%)
>
> diff --git a/scripts/coccinelle/api/alloc/kzalloc-simple.cocci b/scripts/coccinelle/api/alloc/use zalloc functions with extra changes.cocci
> similarity index 100%
> rename from scripts/coccinelle/api/alloc/kzalloc-simple.cocci
> rename to scripts/coccinelle/api/alloc/use zalloc functions with extra changes.cocci

NACK. The name is too long and should not contain spaces.

julia
