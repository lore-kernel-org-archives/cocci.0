From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 7 Oct 2016 14:22:49 +0200
Subject: [Cocci] docs: Fixing "sphinxify coccinelle.txt"?
In-Reply-To: <alpine.DEB.2.10.1610070749420.3074@hadrien>
References: <ea62a1ea-c566-65a0-e2fd-2ee96839cf48@users.sourceforge.net>
 <alpine.DEB.2.10.1610070749420.3074@hadrien>
Message-ID: <b17b77b4-9604-59c0-7808-09463a6a83f5@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> Information from a commit like "docs: sphinxify coccinelle.txt and add it
>> to dev-tools" caught also my software development attention.
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/Documentation/coccinelle.txt?id=4b9033a33494ec9154d63e706e9e47f7eb3fd59e
>>
>> Did an other information from a comment become outdated in the script "coccicheck"
>> because of such changes for the documentation format?
>> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/tree/scripts/coccicheck?id=c802e87fbe2d4dd58982d01b3c39bc5a781223aa#n4
> 
> How about submitting a patch to fix the problem?

Is the published commit (from 2016-08-08 / 2016-08-18) generally questionable
as I see it by the interface "cgit" at the moment?

* Does this one contain only the deletion of the file "Documentation/coccinelle.txt"?

* How should the result from the mentioned action "add it to dev-tools"
  look like finally?

* How could the acknowledgements happen for a software transformation
  which seems to be incomplete there?


I find another data display also interesting and more promising.
https://patchwork.kernel.org/patch/9269973/

* Should this patch about the desired file format conversion become available
  also by the other known interfaces?

* Would it have been nicer to include a corresponding update for the file
  "scripts/coccicheck" there, too?

* Do we need to clarify the distribution of the correct version any further?


Regards,
Markus
