From: rminnich@gmail.com (ron minnich)
Date: Mon, 16 Jan 2017 04:44:39 +0000
Subject: [Cocci] rework a function to move parameters around ....
Message-ID: <CAP6exYJV8O6siwkwin4B+_R=PSOR9HthOfGe0DJsqXaPrN44yg@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

I have a function like this (in coreboot)
void lb_add_serial(struct lb_serial *new_serial, void *data)
{
struct lb_header *header = (struct lb_header *)data;
struct lb_serial *serial;

serial = (struct lb_serial *)lb_new_record(header);
serial->tag = LB_TAG_SERIAL;
serial->size = sizeof(*serial);
serial->type = new_serial->type;
...
}

This is just one example.

I'd like to do the following:
Get the name of the variable assigned to serial->size (call it S)
Get the name of the variable assigned to serial->type (call it T)
Change the code as follows:
serial = (struct lb_serial *)lb_new_record(header, T, S);
remove the lines where they as assigned to struct.
make sure that the call to lb_new_record is moved after the size is
computed (i.e. after the assignments above).

This exceeds my spatch foo by a fair amount; I'm fooling around with it but
wonder if you all have some pointers.

Thanks
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20170116/c875f102/attachment-0001.html>
