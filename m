From: utsav.sb.patel@gmail.com (Utsav Patel)
Date: Fri, 31 Jan 2014 06:05:43 +0530
Subject: [Cocci] Need help in patching
Message-ID: <CACxTi0bZmwJfHgYuA5PUUGViVkAUAdyeZSDHbwBSoQDQu2=NUQ@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi, I have just started to use Coccinelle for my final year BTech project
and I have a question,
The code i want to patch depends upon some conditions. e.g. replace any
array[SIZE] having size > 100 with an array[original_size/2]. See, I don't
want to replace ALL array[size], but only when size>100. So, how do i
compare a constant from an expression (here in example SIZE) to a value
(here in example - 100 ) and perform patching depending on that condition
only?
I guess I can get all array and their SIZE in python script and compare
them, but then i don't know how to filter the selected arrays[] and send it
to another rule to perform patching. Please suggest how can I proceed.

Thank You,
Utsav Patel
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20140131/572ae063/attachment.html>
