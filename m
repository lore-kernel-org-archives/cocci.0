From: jglisse@redhat.com (Jerome Glisse)
Date: Thu, 17 May 2018 10:50:25 -0400
Subject: [Cocci] =?utf-8?q?Checking_consequences_from_=E2=80=9Cexists?=
 =?utf-8?q?=E2=80=9D_usage_with_big_file_name_selection?=
In-Reply-To: <10d2d384-95c0-dec1-b284-f5afb7d9ce81@users.sourceforge.net>
References: <20180516201559.GD2994@redhat.com>
 <10d2d384-95c0-dec1-b284-f5afb7d9ce81@users.sourceforge.net>
Message-ID: <20180517145023.GB5048@redhat.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, May 17, 2018 at 11:11:04AM +0200, SF Markus Elfring wrote:
> > Note i am in no rush, i just wanted to report this as it is likely a bug somewhere
> 
> Thanks for your description of a strange software behaviour.
> 
> How often do you work with the specification ?exists? in other SmPL scripts?

I need to review all of them but i think i can remove most of them
now that Julia explained that i do not need them if there is no ...
between first match and second match in my rules.

> 
> 
> > moreover i have a work around.
> 
> Is the other transformation approach the solution which is really desired?

My work around was to add function with nested block to an extra
group on which i run the same semantic patch again to take care of
nested block when the original group as two big.

This is a minor inconvenience now that i have found why my semantic
patch was not modifying nested block (took me a while to converge
on the number of files as root of the issue).

Cheers,
J?r?me
