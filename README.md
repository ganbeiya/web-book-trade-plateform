
# Project
# Description

Book2Book is a web-based platform designed for OSU students to buy, sell, and manage used books efficiently. It allows students to register and log in using their OSU email, browse and list books for sale, message between buyers and sellers, track transaction history, maintain wishlists, and leave reviews. User
# Use Cases

Use Case 1 - User Registration (Sign Up)
Actors: New User (OSU Student)
Goal: A student wants to create a new account using their OSU email to access the platform.
Preconditions: The user is not registered on the platform.
Main Flow:
The user visits the sign-up page.
They fill in their name, OSU email, and password.
The system checks email validity and uniqueness.
Upon successful submission, the account is created.
	Postconditions: The user is now registered and can proceed to log in.

Use Case 2 - User Login
Actors: Registered User
Goal: The user wants to access their account to use the platform.
Preconditions: The user has already signed up and has valid credentials.
Main Flow:
The user visits the login page.
They enter their OSU email and password.
The system verifies the credentials.
If correct, the user is redirected to the main homepage.
	Postconditions: The user is logged in and can access the core features of the platform.
Use Case 3 - User Logout
Actors: Logged-in User
Goal: The user wants to securely log out from their account.
Preconditions: The user is currently logged in.
Main Flow:
The user clicks the "Log Out" button from the navigation menu.
The system ends the session.
The user is redirected to the public homepage or login page.
	Postconditions: The user is logged out, and their session is cleared.

Use Case 4 - Listing Used Books for Sale
A seller can list a used book for filling out a form with details such as title, author, condition, price, description, and other relevant information
After submitting the form, the book is saved in the database and appears in the public listings for other users to view. Sellers also can edit information or delete it later.

Use Case 5 - Searching and Filtering Books
 Any user can visit the homepage to browse available books. The user can enter a search term (e.g., title, author) and/or apply filters such as price range, condition, or category to refine the results. The system queries the database based on the search and filter criteria and displays matching books in a paginated list. The user can click on a book in the results to view its details and the seller’s contact options.

Use Case 6 - Messaging Between Buyer and Seller
A logged-in user who is interested in a book can open its detail page and see an option to “Message Seller”. The user composes a message and sends it to the seller through an internal messaging system. The seller can view and reply to messages from their dashboard, maintaining a thread of conversation with the buyer. Both parties receive notifications of new messages while logged in.

Use Case 7 - Updating Transaction Status
The seller can manually change the state of the transaction through the transaction detail page. Depending on the current status (available, reserved, in_transaction, or sold), the seller will see actionable buttons (“Accept”, “Reject”, “Completed”). When one of these actions is taken, the system updates the transaction’s status, records the time record, or marks “Completed”, automatically updates the associated listing to “sold”. Only the seller has permission to perform these updates.

Use Case 8 - Allowing user to create and update a Wishlist
Users can build and maintain a personal wishlist of books they are interested in. From any listing or the wishlist page, the user can add a book to their wishlist, optionally set a target price or note, and return to view all saved items. They can update the desired price, add comments, and remove books entirely.

Use Case 9 - Leaving a Review and Rating
Once a transaction is marked as completed, either the buyer or the seller can leave a review and rating for their transaction. The user navigates to the review form on the transaction detail page, selects a star rating (1-5), writes optional text feedback, and submits.The feedback will display on the user’s profile and the listing page. The user may also edit or delete their reviews.

Use Case 10 - Editing User Account
Actors: Logged-in User
Goal: The user wants to update their account information (e.g., name, email, or password).
Preconditions: The user is authenticated and logged in.
Main Flow:
The user navigates to their account settings page.
They edit fields such as name, OSU email, or password.
The system validates the changes (e.g., email format, password strength).
Upon submission, the updated data is saved.
	Postconditions: The user's account information is updated in the system.

Use Case 11 - Deleting User Account 
Actors: Logged-in User
Goal: The user wants to permanently delete their account and associated data.
Preconditions: The user is logged in and confirms their intent to delete the account.
Main Flow:
The user visits the account settings page and clicks “Delete Account.”
The system shows a confirmation prompt.
Upon confirmation, the system deletes the user's account and related data (e.g., listings, messages).
The user is logged out and redirected to the public homepage.
Postconditions: The user’s data is removed, and access to the account is no longer possible.

Use Case 12 - Send the Notification Email about Price Change
Whenever a seller updates the price of one of their listings and the new price meets or falls below a user’s saved target price, the system automatically composes and sends an email to that user. The notification email includes the book’s title, the previous and updated prices, and a direct link to the listing. When signing up, users will get a pop up that shows whether they want to open the notification, if yes, then the price notification will be sent to their email. Otherwise, no actions will be taken.

Use Case 13 - View Transaction History
After logging in, users can view all their completed transaction records in the personal center, including books purchased, books sold, transaction time and price, making it convenient to review and manage past transactions.