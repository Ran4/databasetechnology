#!/usr/bin/python
#encoding: utf-8
import pgdb
from sys import argv

class DBContext:
    """DBContext is a small interface to a database that simplifies SQL.
    Each function gathers the minimal amount of information required and executes the query."""

    def __init__(self): #PG-connection setup
        print "The idea is that you, the authorized database user, log in."
        print("Then the interface is available to employees whos should only "
            "be able to enter shipments as they are made.")
        #params = {'host':'nestor2.csc.kth.se', 'user':raw_input("Username: "),
        #    'database':'', 'password':raw_input("Password: ")}
        params = {'host':'localhost:5432', 'user':'postgres',
            'database':'postgres', 'password':'hejhoppkth'}
        self.conn = pgdb.connect(**params)
        self.menu = ["Record a shipment","Show stock", "Show shipments", "Exit"]
        self.cur = self.conn.cursor()

    def print_menu(self):
        """Prints a menu of all functions this program offers.
            Returns the numerical correspondant of the choice made."""
        for i,x in enumerate(self.menu):
            print("%i. %s"%(i+1,x))
        return self.get_int()

    def get_int(self):
        """Retrieves an integer from the user.
        If the user fails to submit an integer, it will reprompt
        until an integer is submitted."""
        while True:
            try:
                choice = int(input("Choose: "))
                if 1 <= choice <= len(self.menu):
                    return choice
                print("Invalid choice.")
            except (NameError,ValueError, TypeError,SyntaxError):
                print("That was not a number, genious.... :(")
                
    def makeTransaction(self, cid, sid, shipment_isbn, shipment_date, query):
        pass

    def makeShipments(self):
        #THESE INPUT LINES  ARE NOT GOOD ENOUGH
        # YOU NEED TO TYPE CAST/ESCAPE THESE AND CATCH EXCEPTIONS

        #Type casted and using escape_string.
        try:
            cid = int(input("customerID: "))
            sid = int(input("shipment ID: "))
            shipment_isbn = pgdb.escape_string((raw_input("isbn: ")).strip())
            shipment_date = pgdb.escape_string(raw_input("Ship date: ")).strip()
            # THIS IS NOT RIGHT  YOU MUST FORM A QUERY THAT HELPS
            query ="SELECT stock FROM stock WHERE isbn='%s'" %shipment_isbn
        except (NameError, ValueError, TypeError, SyntaxError) as e:
                print "Error in input" + str(e) # Not sure if it works, haven't tested
                return
        print "query=" + query
        
        # HERE YOU SHOULD start a transaction
        #YOU NEED TO Catch exceptions ie bad queries
        try:
            self.cur.execute(query)
            print "The query executed successfully!"
        except pgdb.Error as e:
            print "There was an exception executing the query '%s': %s" %\
                    (query, str(e))
            return
        
        makeTransaction(cid, sid, shipment_isbn, shipment_date, query)
        
        #HERE YOU NEED TO USE THE RESULT OF THE QUERY TO TEST IF THER ARE
        #ANY BOOKS IN STOCK
        value = self.cur.fetchone()
        if not values:
            print ("Book with ISBN:%s not found." % shipment_isbn)
            return

        # YOU NEED TO CHANGE THIS TO SOMETHING REAL
        cnt = 0
        #Sander : Kollade på det ovanför detta dvs. ln 47-67
        if cnt < 1:
            print("No more books in stock :(")
            return
        else:
            print "WE have the book in stock"

        query="""UPDATE stock SET stock=stock-1 WHERE isbn='%s';""" % \
            (shipment_isbn)
        print query
        #YOU NEED TO Catch exceptions  and rollback the transaction
        self.cur.execute(query)
        print "stock decremented"

        query="""INSERT INTO shipments VALUES (%i, %i, '%s','%s');"""  % \
            (sid,cid,shipment_isbn,shipment_date)
        print query
        #YOU NEED TO Catch exceptions and rollback the transaction
        self.cur.execute(query)
        print "shipment created"
        # This ends the transaction (and starts a new one)
        self.conn.commit()

    def showStock(self):
        query="""SELECT * FROM stock;"""
        print query
        try:
            self.cur.execute(query)
        except (pgdb.DatabaseError, pgdb.OperationalError):
            print "  Exception encountered while modifying table data."
            self.conn.rollback ()
            return
        self.print_answer()

    def showShipments(self):
        query="""SELECT * FROM shipments;"""
        print query
        try:
            self.cur.execute(query)
        except (pgdb.DatabaseError, pgdb.OperationalError):
            print "  Exception encountered while modifying table data."
            self.conn.rollback ()
            return
        self.print_answer()
    def exit(self):
        self.cur.close()
        self.conn.close()
        exit()

    def print_answer(self):
        print("\n".join([", ".join([str(a) for a in x]) for x in self.cur.fetchall()]))

    def run(self):
        """Main loop.
        Will divert control through the DBContext as dictated by the user."""
        actions = [self.makeShipments, self.showStock, self.showShipments, self.exit]
        while True:
            try:
                actions[self.print_menu()-1]()
            except IndexError:
                print("Bad choice")
                continue

if __name__ == "__main__":
    db = DBContext()
    db.run()
