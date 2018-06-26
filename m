From: michelemartone@users.sourceforge.net (Michele Martone)
Date: Tue, 26 Jun 2018 12:32:00 +0200
Subject: [Cocci] coccinelle computes patch very slowly
In-Reply-To: <20180626102638.GD14796@localhost>
References: <20180625154402.GC7044@localhost>
 <ff255650-b3d6-c1dc-53ef-8e6e715c5077@users.sourceforge.net>
 <20180626102638.GD14796@localhost>
Message-ID: <20180626103200.GE14796@localhost>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 20180626 at 11:20, SF Markus Elfring wrote:
> > While patching source files of a few thousand lines long,
> > I noticed prohibitively long patch compute times (seemed hanged).
> 
> Do you get nicer run time characteristics if you would refactor the SmPL script
> example like the following for the addition of a type cast?
> 
> // A semantic patch introducing casting on function return:
> @@
> identifier F, V;
> type T;
> @@
>  T V;
>  ...
>  V =
> +    (T)
>      F(...);

Hi Markus,

using your patch
(having F as any identifier, rather than a specific token)
does not change anything time-wise, unfortunately :-(

p.s.: My general problem actually was more complicated than this,
  in that the variables declarations can be anywhere, while this
  patch here requires declaration and F call to be in the same
  scope.

Michele
