From: kumar.gala@linaro.org (Kumar Gala)
Date: Fri, 27 Jan 2017 12:39:14 -0600
Subject: [Cocci] Help with include coccinelle & include paths?
In-Reply-To: <alpine.DEB.2.20.1701271828190.3025@hadrien>
References: <BBB6D7E1-F6F1-4FE4-80D6-8BD4C6F36026@linaro.org>
 <alpine.DEB.2.20.1701261613120.3109@hadrien>
 <C37E98C9-25E1-4E62-BA80-145CC8483C79@linaro.org>
 <alpine.DEB.2.20.1701262014580.2032@hadrien>
 <BEC46CAB-77E1-4237-B5A0-C9E84BF192DA@linaro.org>
 <alpine.DEB.2.20.1701262055170.2032@hadrien>
 <BB7CE4F7-355C-4CC3-818A-03C47112E293@linaro.org>
 <BD76D02F-FBF3-4F69-9C5B-8C2976D7DFFA@linaro.org>
 <alpine.DEB.2.20.1701262118460.2032@hadrien>
 <6FBEB071-6A44-4A39-9C40-5E28CC402196@linaro.org>
 <alpine.DEB.2.20.1701262149330.2032@hadrien>
 <5A897B79-A0C3-44D5-9FB8-3D0DFBB5A3B1@linaro.org>
 <alpine.DEB.2.20.1701262236200.2032@hadrien>
 <199ADD09-0E16-4483-A391-7929C25C8731@linaro.org>
 <alpine.DEB.2.20.1701271828190.3025@hadrien>
Message-ID: <FA28196E-7814-4786-814D-B46D2DEE91EE@linaro.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr


> On Jan 27, 2017, at 11:30 AM, Julia Lawall <julia.lawall@lip6.fr> wrote:
> 
> I have undone a rather nice optimization to get the header files to be
> reprocessed each time they are included by a .c file.  The problem is that
> parsing a header file has some side effects, eg finding about typedefs,
> etc.  Unfortunately, we were caching only the AST of the header file, but
> not either the ASTs of the header files it includes or the effects that
> parsing the header files could have.
> 
> Now I have undone the optimization, and hopefully it will work better,
> although more slowly.
> 
> Available on github.
> 
> julia

Thanks, that seems to help a lot.

I was wondering what the following message means, the bit about the header file:

HANDLING: tests/bluetooth/test_bluetooth/src/bluetooth.c
a header file was modified: bluetooth.h

- k
