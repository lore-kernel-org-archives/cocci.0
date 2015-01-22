From: eliseomarmol@gmail.com (=?windows-1252?Q?Eliseo_Mart=EDnez?=)
Date: Thu, 22 Jan 2015 10:36:07 +0100
Subject: [Cocci] Matching functions with attributes
In-Reply-To: <606B3094-FA8F-4BC7-BDE2-FC0974EAE640@gmail.com>
References: <D59A6A6F-9D60-44DE-9B6C-8B615B776EA8@gmail.com>
 <54BFD099.8030002@users.sourceforge.net>
 <F6392E9E-0D22-4398-8173-DD84FFEBAB98@gmail.com>
 <alpine.DEB.2.10.1501212342170.2599@hadrien>
 <02347CD6-6A31-41A9-B4EE-58163C49368C@gmail.com>
 <54C0BBF9.3040804@users.sourceforge.net>
 <606B3094-FA8F-4BC7-BDE2-FC0974EAE640@gmail.com>
Message-ID: <D95203B4-68FF-49C9-B886-738F3AC9E725@gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr


> How do you manage the knowledge for your function name list?

I don?t manage it. 
When I first wanted to do this task of detecting unnecessary null checks, I thought I could match such functions through SmPL.
As it seemed to be impossible, then I extracted that list manually (grepping for FUNC_ATTR_NONNULL_RET).
Now, to automate that task for future retries of this task, I?m thinking about a vim-based solution (grepping into quicklist window, and execcuting a macro on each result to accumulate names in a variable).

> How much does the SmPL star functionality matter here for you?

Not sure I understand your question. Star functionality is crucial for me there, as I?m using this spatch to find spots in the code that I want to manually review.

> Do you need to get the source code analysis results also in other data formats?

No, at least by now. As I said, I?m using this patch just to get pointers to places in code I?d like to review.
