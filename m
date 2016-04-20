From: kieranbingham@gmail.com (Kieran Bingham)
Date: Wed, 20 Apr 2016 17:55:05 +0100
Subject: [Cocci] Dependencies between spatch hunks
In-Reply-To: <alpine.DEB.2.10.1604201846020.3089@hadrien>
References: <571787F0.7050200@gmail.com>
 <alpine.DEB.2.10.1604201846020.3089@hadrien>
Message-ID: <CAB3z_RpvWFkYoPY4uh4+HuNhM=4OBDb31O0Q6xZ2LoRAv5V=mw@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 20 Apr 2016 17:46, "Julia Lawall" <julia.lawall@lip6.fr> wrote:
>
>
>
> On Wed, 20 Apr 2016, Kieran Bingham wrote:
>
> > Hi all,
> >
> > I am finding that a rule which matches a part of code, sometimes causes
> > hunks which depend on it to act, and sometimes not to act
> >
> > My spatch is successfully removing and converting hunks that I desire
> > changed, however the requirement became apparent *to not process the
> > file at all* if the variable is used in the probe function, so I added
> > in a dependency on probe_id_unused (established in my previous mail
thread).
> >
> > Therefore, I would expect to be able to set the 'depends on' to be on
> > 'probe_id_unused' for each of the actions, and have actions only taken
> > if the full dependency chain (C4->C1 below) is met.
> >
> > However, I get a non-consistent application of this, where some hunks
> > operate when (I believe) they shouldn't:
> >
> > My full spatch for reference, is at:
> >
> > https://gist.github.com/kbingham/96477177dd20a72b1c2f
> >
> > In essence, it does the following {C}hecks:
> > C1 - of_dev_id_present : Check for a struct of_device_id
> > C2 - dev_id : Check for a struct i2c_device_id
> > C3 - driver : Check and identify the probefunc in the driver structure
> > C4 - probe_id_unused : Establish if the id is used in the probe function
> >
> > Where C4 depends on C3 depends on C2 depends on C1
> >
> > The aim is that if all of the above checks/identifiers are met, it will
> > take the following actions:
> > A rewrite the probe function declaration
> > B re-point the function pointer in the driver structure
> > C remove the i2c_device_id reference
> > D remove the i2c_device_id array
> > E remove the MODULE_DEVICE_TABLE macro
> >
> > For this example, I'll take three files from the kernel source, all of
> > which meet conditions C1 - > C3 (but only F3 meets C4):
> >
> > F1: drivers/gpio/gpio-pca953x.c  : probe id used ( ! C4 )
> > F2: drivers/staging/iio/light/isl29018.c : probe id used ( ! C4 )
> > F3: sound/soc/codecs/wm8737.c : probe id UNUSED ( C4 )
> >
> > If all the actions (A->E) start with @ depends on driver @ (to depend on
> > C3) all the actions complete on these files. (Shown in sequence in the c
> > file)
> >
> > F1 : D E A B C
> > F2 : A D E B C
> > F3 : A D E B C
> >
> > However, if all the actions depend on @ depends on probe_id_unused @
> > (depends on C4), Some actions complete, and some do not!
> >
> > F1 : D E C       (Unexpected behaviour - I expect F1 : <no change>)
> > F2 : D E C       (Unexpected behaviour - I expect F2 : <no change>)
> > F3 : A D E B C   (Expected behaviour)
> >
> > So of course, I want actions D E and C to *not* complete on F1 and F2,
> > but I can't understand why they do not comply with their 'depends'
> > chain. Am I looking at a bug in Coccinelle here or a bug with my
> > interpretation of the depends keyword?
> >
> > Sorry for the long mail, and look forward to any ideas!
>
> What version of Coccinelle do you have?  I get the expected behavior.  No
> change on F1 and F2, and a change on F3.

I think the fault was somewhere between the keyboard and chair :-)

I'm away from my keyboard now,  so I can't check but I'll assume it was
because I was specifying the files in one command line.

Regards

Kieran

>
> julia
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20160420/dfcb6499/attachment-0001.html>
