From: christof@warlich.name (Christof Warlich)
Date: Fri, 02 Jan 2015 11:22:09 +0100
Subject: [Cocci] adding function declarations
In-Reply-To: <alpine.DEB.2.02.1501011829330.2060@localhost6.localdomain6>
References: <54A55D15.5020306@warlich.name>
 <alpine.DEB.2.02.1501011829330.2060@localhost6.localdomain6>
Message-ID: <54A67151.5080408@warlich.name>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Am 01.01.2015 um 18:33 schrieb Julia Lawall:

 > Unfortunately, your seemingly simple request raises some issues :)

 > First, you should apply the patch below to Coccinelle version 
1.0.0-rc23 (the latest version)

It looks like you missed to include the patch you mentioned: I couldn't 
find anything appropriate to apply to the Coccinelle source code. Thus, 
I'm still playing with an unpatched version 1.0.0-rc23.

 > For some reason, the semantic patch parser is not allowing me to put
 > inline in the prototype. I will look into it and send another patch.
 >
 > Also for the following file:
 >
 > static inline __attribute__((always_inline)) int foo(int x) {
 >     return x;
 > }
 >
 > the output is missing a space before the attribute:
 > ...

Yes, I could reproduce both using 1.0.0-rc23.

 > I will look into this as well.

Again, many thanks for your help and your precious  time: So I'll 
patiently wait for a patch :-). But please let me know if anything else 
can be done on my side.

Cheers,

Chris
