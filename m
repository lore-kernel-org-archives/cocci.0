From: mstefani@redhat.com (Michael Stefaniuc)
Date: Wed, 07 Jan 2015 16:41:41 +0100
Subject: [Cocci] Source code analysis for header files
In-Reply-To: <alpine.DEB.2.10.1501071630480.3328@hadrien>
References: <54A3F836.7060903@users.sourceforge.net>
 <alpine.DEB.2.10.1412311439380.2559@hadrien>
 <54A40032.4070904@users.sourceforge.net>
 <alpine.DEB.2.10.1412311457130.2559@hadrien>
 <54A403EB.8080709@users.sourceforge.net>
 <54AD430E.2000507@users.sourceforge.net>
 <alpine.DEB.2.10.1501071549410.3328@hadrien>
 <54AD4FC5.3000001@users.sourceforge.net>
 <alpine.DEB.2.10.1501071630480.3328@hadrien>
Message-ID: <54AD53B5.1030000@redhat.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 01/07/2015 04:31 PM, Julia Lawall wrote:
> 
> 
> On Wed, 7 Jan 2015, SF Markus Elfring wrote:
> 
>>>> Would you like to extend use cases for your source code 
>>>> analysis and transformation software in this design
>>>> direction?
>>> 
>>> There is an option --include-headers to take into account .h
>>> files.  I guess there could be anoption --exclude-c-files if
>>> there is enough interest to warrant the addition of yet another
>>> option.
>> 
>> An "exclude option" does not sound promising for my feature 
>> request around including more possibilities, does it?
> 
> I don't see the problem - C files are included by default, so one
> might perhaps want the option to exclude them.
> 
> But what else is there?
`find -name \*.h` has the same length to type and is easier to remember.
That's what I use in the very few situations that I needed that feature.

bye
	michael
