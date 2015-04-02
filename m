From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 2 Apr 2015 20:27:55 +0200 (CEST)
Subject: [Cocci] Add code to functions that use a certain variable
In-Reply-To: <CAP6exYJacksEinpk_djJ5VYT85o0yBeqOQbZPWURadTrQKTzhA@mail.gmail.com>
References: <CAP6exYJacksEinpk_djJ5VYT85o0yBeqOQbZPWURadTrQKTzhA@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1504022027020.2053@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, 2 Apr 2015, ron minnich wrote:

> I have this typedef in Plan 9typedef struct Mach Mach;
> 
> a global?
> Mach *m;
> 
> and functions:
> a(...){
> ...
> m->whatever = x;
> ...
> }
> 
> I want to add some code after the {
> +Mach *m=machp();
> 
> I.e. for any function that uses the "global" (it's not really that, it's a
> bit more complex) I want to add a local variable that is initialized.
> 
> My efforts so far have failed badly.

Could you send an example of a badly failing effort?

thans,
julia
