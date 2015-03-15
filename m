From: haohaiziround@hotmail.com (ZhouYuan)
Date: Sun, 15 Mar 2015 21:39:59 +0800
Subject: [Cocci] Errors of the examples in the source code
Message-ID: <BAY181-W10D748E51733C0491E2E48B8050@phx.gbl>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi,
Here I have met some problems when running some demos in the directory demos of the source code of coccinelle (version 1.0.0-rc10). 
For example, if I run "spatch --sp-file pycocci.cocci pycocci.c" in Linux, I would get an error as following:  
  File "<string>", line 3, in <module>  File "/usr/share/coccinelle/python/coccilib/output.py, line 22, in combine    nmv.location = nloc[0]AttributeError: 'str' object has no attribute 'location'Failure in rule starting on line 9Fatal error: exception Pycocci.Pycocciexception
I also attach a picture show the error. 
              

I also have found some other problems when running some existed examples under the directory demos and tests of the source file. 
It would be a great hornor for me if someone could give any suggestions to the errors ocurred in the demos. 
Thank you so much and looking forward to your reply.
Best regards,Yuan ZHOU
 		 	   		  
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20150315/025d91c6/attachment-0001.html>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: a.jpg
Type: image/jpeg
Size: 82500 bytes
Desc: not available
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20150315/025d91c6/attachment-0001.jpg>
