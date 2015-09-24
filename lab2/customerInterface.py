#!/usr/bin/python
import pgdb
from sys import argv
#  Here you shall complete the code to allow a customer to use this interface to check his or her shipments.
#  You will fill in the 'shipments' funtion

#  The code should not allow the customer to find out other customers or other booktown data.
#  Security is taken as the customer knows his own customer_id, first and last names.
#  So not really so great but it illustrates how one would check a password if there were the addition of encription.

#  Most of the code is here except those little pieces needed to avoid injection attacks.
#  You might want to read up on pgdb, postgresql, and this useful function: pgdb.escape_string(some text)

#  You should also add exception handling.  Search WWW for 'python try' or 'exception' for things like:
#         try:
#             ...
#         except (errorcode1, errorcode2,...):
#             ....
# A good tip is the error message you get when exceptions are not caught such as:
#  Traceback (most recent call last):
#  File "./customerInterface.py", line 105, in <module>
#    db.run()
#  File "./customerInterface.py", line 98, in run
#    actions[self.print_menu()-1]()
#  File "./customerInterface.py", line 68, in shipments
#    self.cur.execute(query)
#  File "/usr/lib/python2.6/dist-packages/pgdb.py", line 259, in execute
#    self.executemany(operation, (params,))
#  File "/usr/lib/python2.6/dist-packages/pgdb.py", line 289, in executemany
#    raise DatabaseError("error '%s' in '%s'" % (msg, sql))
# pg.DatabaseError: error 'ERROR:  syntax error at or near "*"
# LINE 1: SELECT * FROM * WHERE *
#
#  You should think "Hey this pg.DatabaseError (an error code) mentioned above could be caught at
#  File "./customerInterface.py", line 68, in shipments  self.cur.execute(query) also mentioned above."
#  The only problem is the codes need to be pgdb. instead of the pg. shown in my output
#  (I am not sure why they are different) so the code to catch is pgdb.DatabaseError.
#
#
class DBContext:
    """DBContext is a small interface to a database that simplifies SQL.
    Each function gathers the minimal amount of information required and executes the query."""

    def __init__(self): #PG-connection setup
        #print("AUTHORS NOTE: If you submit faulty information here, I am not responsible for the consequences.")
        #print "The idea is that you, the authorized database user, log in."
        #print "Then the interface is available to customers whos should only be able to see their own shipments."
        #params = {'host':'nestor2.csc.kth.se', 'user':raw_input("Username: "), 'database':'', 'password':raw_input("Password: ")}
        params = {'host':'localhost:5432', 'user':'postgres', 'database':'postgres', 'password':'hejhoppkth'}
        self.conn = pgdb.connect(**params)
        self.menu = ["Shipments Status", "Exit"]
        self.cur = self.conn.cursor()

    def print_menu(self):
        """Prints a menu of all functions this program offers.  Returns the numerical correspondant of the choice made."""
        print
        for i, x in enumerate(self.menu):
            print("%i. %s" % (i+1,x))
        return self.get_int()

    def get_int(self):
        """Retrieves an integer from the user.
        If the user fails to submit an integer, it will reprompt until an integer is submitted."""
        while True:
            try:
                choice = int(input("Choose: "))
                if 1 <= choice <= len(self.menu):
                    return choice
                print("Invalid choice.")
            except (NameError,ValueError, TypeError,SyntaxError):
                print("That was not a number, genious.... :(")

    def shipments(self):
        print "In shipments()"
        # These input funtions are not correct so  exceptions caught and handled.

        # ID should be hard typed to an integer
        #  So think that they can enter: 1 OR 1=1
        while True:
            try:
                ID = int(raw_input("customerID: "))
                break
            except ValueError:
                print "customerID has to be an integer!"
        # These names inputs are terrible and allow injection attacks.
        #  So think that they can enter: Hilbert' OR 'a'='a
        #fname = (raw_input("First Name: ").strip())
        #lname = raw_input("Last Name: ").strip()
        fname = pgdb.escape_string((raw_input("First Name: ").strip()))
        lname = pgdb.escape_string(raw_input("Last Name: ").strip())
        fname = "'%s'" % fname
        lname = "'%s'" % lname
        # THIS IS NOT RIGHT YOU MUST FIGURE OUT WHAT QUERY MAKES SENSE
        #query = "SELECT something FROM somewhere WHERE something"
        query = "SELECT customer_id, last_name, first_name FROM customers "
        query += "WHERE customer_id={ID} AND last_name={lname} AND first_name={fname};".format(
                ID=ID, fname=fname, lname=lname)
        #print "query='%s'\n" % query

        #NEED TO Catch excemptions ie bad queries  (ie there are pgdb.someError type errors codes)
        try:
            self.cur.execute(query)
            #print "The query executed successfully!"
        except pgdb.DatabaseError as e:
            print "There was an exception executing the query '%s': %s" %\
                    (query, str(e))
            self.exit()

        if len(fname) >= 2:
            fname = fname[1:-1]
        if len(lname) >= 2:
            lname = lname[1:-1]

        # NEED TO figure out how to get and test the output to see if the customer is in customers
        # test code here...
        # HINT: in pyton lists are accessed from 0 that is mylist[0] is the first element
        # also a list of a list (such as the result of a query) has two indecies so starts with mylist[0][0]
        # now the test is done
        if self.cur.fetchone():
            #print "Good name!"
            pass
        else:
            print "Couldn't find the customer {lname}, {fname} with id {id}.".format(
                    id=ID, fname=fname, lname=lname)
            print "Check your ID, first name or last name (consider the case!)"
            return
        # THIS IS NOT RIGHT YOU MUST PRINT OUT a listing of shipment_id,ship_date,isbn,title for this customer
        #query ="SELECT something FROM somewhere WHERE conditions"
        #query ="SELECT shipment_id, ship_date, isbn, title FROM shipments WHERE customer_id={id}".format(id=ID)
        #query ="SELECT shipment_id, ship_date, isbn, title FROM shipments, books WHERE customer_id={id}".format(id=ID)
        query = """SELECT shipment_id, ship_date, isbn, title
        FROM shipments NATURAL JOIN books NATURAL JOIN editions
        WHERE customer_id={id}""".format(id=ID)

        # YOU MUST CATCH EXCEPTIONS HERE AGAIN
        try:
            self.cur.execute(query)
            #print "The query executed successfully!"
        except pgdb.DatabaseError as e:
            print "There was an exception executing the query '%s': %s" %\
                    (query, str(e))
            self.exit()

        values = self.cur.fetchall()

        print "Customer {id} {fname} {lname}:".format(
                id=ID,
                #fname=pgdb.escape_string(fname),
                #lname=pgdb.escape_string(lname))
                fname=fname,
                lname=lname)
        #print "\tshipment_id\tship_date\tisbn\ttitle"
        print "\tship_id\tship_date\t\tisbn\t\ttitle"
        for shipment in values:
            print "\t" + "\t".join(map(str, shipment))

        # Here the list should print for example:
        #    Customer 860 Tim Owens:
        #    shipment_id,ship_date,isbn,title
        #    510, 2001-08-14 16:33:47+02, 0823015505, Dynamic Anatomy

    def exit(self):
        self.cur.close()
        self.conn.close()
        exit()

    def print_answer(self):
            print("\n".join([", ".join([str(a) for a in x]) for x in self.cur.fetchall()]))

    def run(self):
        """Main loop.
        Will divert control through the DBContext as dictated by the user."""
        actions = [self.shipments, self.exit]
        while True:
            try:
                actions[self.print_menu()-1]()
            except IndexError:
                print("Bad choice")
                continue

if __name__ == "__main__":
    db = DBContext()
    db.run()
