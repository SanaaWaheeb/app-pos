const express = require("express");
const mysql = require("mysql");
const cors = require("cors");

const app = express();
app.use(cors());
app.use(express.json());

// MySQL Connection
const db = mysql.createConnection({
    host: "localhost",
    user: "root",
    password: "",
    database: "u513213599_sys"
});

db.connect(err => {
    if (err) {
        console.error("Database connection failed:", err);
        return;
    }
    console.log("Connected to MySQL");
});

// ------------------ Define API routes ------------------
// API Route: Fetch Users
app.get("/users", (req, res) => {
    const query = "SELECT * FROM users";
    db.query(query, (err, results) => {
        if (err) {
            res.status(500).json({ error: err });
            return;
        }
        res.json(results);
    });
});

// API Route: filter products
app.get('/products/:boardId', (req, res) => {
    const boardId = req.params.boardId;

    // Step 1: Find machine_id from machines table where name matches boardId
    const machineQyery = "SELECT id from machines where name = ?";
    db.query(machineQyery, [boardId],  (err, machineResults) => {
        if (err || machineResults.length === 0) {
            return res.status(404).json({ error: "Machine not found" });
        }

        const machineId = machineResults[0].id;

        // Step 2: Find track_ids from tracks table for this machine id
        const trackQurry = "SELECT product, price from tracks where machine = ?";
        db.query(trackQurry, [machineId], (err, trackResults) => {
            if (err || trackResults.length === 0) {
                return res.status(404).json({ error: "No tracks found for this machine" });
            }
            const productIds = trackResults.map(track => track.product);

            // Step 3: Fetch product details from products table
            const productQuery = "SELECT * FROM products WHERE id IN (?)";
            db.query(productQuery, [productIds], (err, productResults) => {
                if (err || productResults.length === 0) {
                    return res.status(404).json({ error: "No products found" });
                }

                // Merge track price with product details
                const finalProducts = productResults.map(product => {
                    const track = trackResults.find(t => t.product === product.id);
                    return {
                        ...product,   // Spread original product details
                        price: track.price // Add price from trackResults
                    }
                })
                res.json(finalProducts);
            })
        })
    })
})

// API Route: fetch machine id
app.get('/machine-id/:boardId', (req, res) => {
    const boardId = req.params.boardId;
    const query = "SELECT id FROM machines where name = ?";

    db.query(query, [boardId], (err, result) => {
        if (err) {
            res.status(500).json({ error: err });
            return;
        }
        res.json(result);
    })
})

// Start Server
app.listen(3000, () => {
    console.log("Server running on port 3000");
});
