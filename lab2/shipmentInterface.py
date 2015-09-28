#!/usr/bin/python
#encoding: utf-8
import pgdb
from sys import argv
import sys

class DBContext:
    """DBContext is a small interface to a database that simplifies SQL.
    Each function gathers the minimal amount of information required and executes the query."""

    def __init__(self): #PG-connection setup
        print "The idea is that you, the authorized database user, log in."
        print("Then the interface is available to employees whos should only "
            "be able to enter shipments as they are made.")
        #params = {'host':'nestor2.csc.kth.se', 'user':raw_input("Username: "),
        #    'database':'', 'password':raw_input("Password: ")}
        #params = {'host':'localhost:5432', 'user':'postgres',
        #    'database':'postgres', 'password':'hejhoppkth'}
        params = {'host':'localhost:5432', 'user':'postgres',
            'database':'postgres', 'password':'postgressander'}
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
                
        
    def _addShipment(self, sid, cid, shipment_isbn, shipment_date):
        query="""INSERT INTO shipments VALUES (%i, %i, '%s','%s');"""  % \
            (sid,cid,shipment_isbn,shipment_date)
        #print query
        #YOU NEED TO Catch exceptions and rollback the transaction
        try:
            self.cur.execute(query)
            print "Shipment created"
            #print "The _addShipment query executed successfully!"
        except pgdb.Error as e:
            print "There was an exception: %s, performing rollback" % str(e)
            self.conn.rollback()
            return False
        return True
    
    def _updateStock(self, shipment_isbn):
        """Returns True if we successfully updated stock"""
        query="""UPDATE stock SET stock=stock-1 WHERE isbn='%s';""" % \
            (shipment_isbn)
        #print "updateStock query: %s" % query
        #YOU NEED TO Catch exceptions  and rollback the transaction
        try:
            self.cur.execute(query)
            print "Stock decremented"
            #print "The _updateStock query executed successfully!"
        except pgdb.Error as e:
            print "There was an exception: %s, performing rollback" % str(e)
            self.conn.rollback()
            return False
        return True
    
    def _checkResultOfQuery(self, shipment_isbn):
        #HERE YOU NEED TO USE THE RESULT OF THE QUERY TO TEST IF THER ARE
        #ANY BOOKS IN STOCK
        stock_values = self.cur.fetchone()
        #print "stock_value is %s, of type %s" % (stock_values, type(stock_value))
        if stock_values == None:
            print ("Book with ISBN %s not found." % shipment_isbn)
            return 0

        if stock_values[0] <= 0:
            print("No more books in stock :(")
            return 0
        else:
            print "We have the book in stock"
            return stock_values[0]
        
    def _makeTransaction(self, query):
        try:
            self.cur.execute(query)
            #print "The query executed successfully!"
        except pgdb.Error as e:
            print "There was an exception: %s" % str(e)
            return
    
    def _getShipmentInfo(self):
        try:
            cid = int(input("customerID: "))
            sid = int(input("shipment ID: "))
            shipment_isbn = pgdb.escape_string((raw_input("isbn: ")).strip())
            shipment_date = pgdb.escape_string(raw_input("Ship date: ")).strip()
            # THIS IS NOT RIGHT  YOU MUST FORM A QUERY THAT HELPS
            query ="SELECT stock FROM stock WHERE isbn='%s'" % shipment_isbn
        except (NameError, ValueError, TypeError, SyntaxError) as e:
                print "Error in input" + str(e) # Not sure if it works, haven't tested
                return None
        #print "query=" + query
        
        result = (sid, cid, shipment_isbn, shipment_date, query)
        return result

    def makeShipments(self):
        self.conn.commit() #Here the transaction starts
        
        result = self._getShipmentInfo()
        if result:
            sid, cid, shipment_isbn, shipment_date, query = result
        else:
            return
        
        self._makeTransaction(query)
        if self._checkResultOfQuery(shipment_isbn) <= 0: return
        if not self._updateStock(shipment_isbn): return
        self._addShipment(sid, cid, shipment_isbn, shipment_date)
        self.conn.commit() #If we got here, everything should be fine

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
