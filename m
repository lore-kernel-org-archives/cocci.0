From: waldemar.rymarkiewicz@gmail.com (Waldemar Rymarkiewicz)
Date: Wed, 14 Sep 2016 15:31:15 +0200
Subject: [Cocci] Match #define in cocci
Message-ID: <CAHKzcEN9fcOk1HCar=u+htx=o61xF61VmbO9PeYPBaedTQYDcg@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi,

I'm new to cocci and try to understand how all this things work. I
have a problem with matching a #define  in a patch.

I wan to match local definition

   #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

and  add #undef  it first. The output should be like this

   #undef  pr_fmt
   #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

I tried many approaches but seems like parser have a problem with
parsing #defines.

Is that possible to achieve  what I expect in cocci ?


Cheers
/Waldek
