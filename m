From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 23 Oct 2012 21:18:44 +0200 (CEST)
Subject: [Cocci] licensing concerns with cocci patches
In-Reply-To: <CAF6rxgmsuyxzTQOO1=WSBvqVixrj0T+k6x2wDNiFiObuRSi82g@mail.gmail.com>
References: <CAF6rxgkr4aQ-b8HpxJ9w8FMOTL63w7GFJqF5FD5MOwaJ3Kni5w@mail.gmail.com>
 <alpine.DEB.2.02.1210221902220.3683@hadrien>
 <CAF6rxgmsuyxzTQOO1=WSBvqVixrj0T+k6x2wDNiFiObuRSi82g@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1210232115200.1942@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Tue, 23 Oct 2012, Eitan Adler wrote:

> On 22 October 2012 13:05, Julia Lawall <julia.lawall@lip6.fr> wrote:
>> My understanding is that the output of a semantic patch should not be GPL.
>> But I am not an expert.  In any case, that is the intent.  We would
>> certainly be happy that the scripts be part of BSD.
>
> Awesome. Hopefully I will be able to start gathering a set of useful
> scripts soon.

I wonder if for BSD you are actually interested in using the rules that do 
transformation?  Most of the rules that are distributed with Linux can be 
used in several ways, to do transformation or to print a report.  For the 
ones that only print reports, I guess there is no problem at all, because 
no code is generated?  I'm not sure what would be the status of the rules 
that can do transformation if you only use them to generate reports.

julia
