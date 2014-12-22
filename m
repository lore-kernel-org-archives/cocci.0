From: mstefani@redhat.com (Michael Stefaniuc)
Date: Mon, 22 Dec 2014 14:33:49 +0100
Subject: [Cocci] Change function invocations argument
In-Reply-To: <alpine.DEB.2.02.1412211459520.2050@localhost6.localdomain6>
References: <F51E5D4A-BD27-4192-95B7-2164D25A4380@gmail.com>
 <alpine.DEB.2.02.1412202131540.2098@localhost6.localdomain6>
 <254A1CAA-2FA6-4546-91BD-5E0C449C7F94@gmail.com>
 <alpine.DEB.2.02.1412202147460.2098@localhost6.localdomain6>
 <D2F6C23B-F5FF-41DE-86B3-8C7210DA61BD@gmail.com>
 <alpine.DEB.2.02.1412211157000.2068@localhost6.localdomain6>
 <2BD158D5-96AC-4BEC-81B9-F07A54C7BEEB@gmail.com>
 <5496B54D.8050501@users.sourceforge.net>
 <alpine.DEB.2.02.1412211302450.2068@localhost6.localdomain6>
 <6C06025D-6720-4BBD-9D44-75802D8A5B53@gmail.com>
 <alpine.DEB.2.02.1412211459520.2050@localhost6.localdomain6>
Message-ID: <54981DBD.5000300@redhat.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 12/21/2014 03:01 PM, Julia Lawall wrote:
> 
> 
> On Sun, 21 Dec 2014, Eliseo Mart?nez wrote:
> 
>> That?s right. I wanted to remove external parentheses, which
>> wasn?t done if employing only e2/e3. I hadn?t realized using
>> (e2)/(e3) would take care of both cases (with/without
>> parentheses), though.
>> 
>> BTW, is there an easy way to remove **all** unneeded parentheses,
>> project wide?
> 
> Probably not.  You could remove all parentheses, but that might
> risk removing some needed ones.  On the other hand, Coccinelle does
> know something about precedednce, so you could try:
> 
> -( e1 -)
> 
> and see what happens.  Probably it will do more than you expect,
> though.
Though it is easy to validate that the generated patch is truly a
no-op. I use a sha1sum on the generated object files without and with
the patch and compare those. Of course there is the danger that the
code touched was ifdef'ed out so some developer discretion is still
needed.

bye
	michael
