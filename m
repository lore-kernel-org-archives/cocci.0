From: elena.reshetova@intel.com (Reshetova, Elena)
Date: Thu, 17 Aug 2017 07:22:17 +0000
Subject: [Cocci] Coccinelle: add atomic_as_refcounter script
In-Reply-To: <ae535db6-f568-9424-466d-596844c1ab9f@users.sourceforge.net>
References: <1502884342-10702-2-git-send-email-elena.reshetova@intel.com>
 <ae535db6-f568-9424-466d-596844c1ab9f@users.sourceforge.net>
Message-ID: <2236FBA76BA1254E88B949DDB74E612B6FF489CB@IRSMSX102.ger.corp.intel.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr


> Dear Elena,

Hi Markus!

> 
> Why do you insist to use the variables ?fname2? till ?fname6? in
> this evolving SmPL script (instead of merging them into a single one
> with a special constraint)?

I am pretty new to Coccinelle and Julia has recommended against this approach, so I was merely following her advice. 
I really do not understand the implications of the change as well as she does. 
Your approach would certainly look prettier script-wise, but I don't want to cause any undesirable side-effects. 

> 
> How do you think about to omit the cover letter for the addition
> of such a script (when the change log can be integrated into
> the same message for your update suggestion)?

Sorry, not sure I understood this. Could you please explain more? 
> 
> Regards,
> Markus
