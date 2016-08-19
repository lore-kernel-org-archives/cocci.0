From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 19 Aug 2016 18:56:17 +0200
Subject: [Cocci] Coccinelle: Script to replace allocate and memset with
 zalloc functions
In-Reply-To: <alpine.DEB.2.10.1608190928520.3078@hadrien>
References: <20160801070233.GA19102@amitoj-Inspiron-3542>
 <d3dde65e-a1d5-54ba-d65f-9e996bb4f8f5@users.sourceforge.net>
 <CA+5yK5HNhcYV+OWhvvgax-fvbtSXEHgPh0mxzWFPFc6-ubzJEQ@mail.gmail.com>
 <33c75c5f-59d5-5fd4-6767-6144b4f245bc@users.sourceforge.net>
 <alpine.DEB.2.10.1608190928520.3078@hadrien>
Message-ID: <72849249-8bbd-f6c7-dce3-ca633d591c67@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> Do you prefer to exclude such functions which belong to subsystems
>> so far generally?
> 
> Yes, because it would introduce unwanted dependencies.

Are the mentioned dependencies easier to handle for subsystems
like "acpi", "dma" and "pci" (than "kvm")?

Would anybody like to tackle any further software development
challenges there?

Regards,
Markus
