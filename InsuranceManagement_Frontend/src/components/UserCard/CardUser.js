import React, { useState, useEffect } from "react";
import Card from "@mui/material/Card";
import CardContent from "@mui/material/CardContent";
import { baseURL } from "../../Server";
import { useUserInfo } from "../../utils/useUserInfo";
import getCurrentUserId from "../../utils/getCurrentUserId";
import axios from "axios";

function CardUser() {
  const userId = getCurrentUserId();
  const information = useUserInfo(userId);
  const [userData, setUserData] = useState({});
  const [editedUserData, setEditedUserData] = useState({});
  const [error, setError] = useState("");
  const [isDirty, setIsDirty] = useState(false);

  const handleInputChange = (e) => {
    const { name, value } = e.target;
    setEditedUserData({
      ...editedUserData,
      [name]: value,
    });
    setIsDirty(true);
  };

  const handleUpdate = async () => {
    if (
      editedUserData?.Firstname?.trim() === "" ||
      editedUserData?.Lastname?.trim() === "" ||
      editedUserData?.Address?.trim() === ""
    ) {
      setError("Please fill all the details");
      return;
    }

    const phoneNumber = String(editedUserData.PhoneNumber).trim();
    if (!/^\d{10}$/.test(phoneNumber)) {
      setError("Please enter a valid phone number");
      return;
    }

    if (
      !/^[a-zA-Z]*$/.test(editedUserData.Firstname) ||
      !/^[a-zA-Z]*$/.test(editedUserData.Lastname)
    ) {
      setError("First name and last name should contain only alphabets");
      return;
    }
    console.log({
      firstName: editedUserData.Firstname || information.information.firstName,
      lastName: editedUserData.Lastname || information.information.lastName,
      phoneNumber:
        editedUserData.PhoneNumber || information.information.phoneNumber,
    });
    const response = await axios.put(`${baseURL}/user/${userId}`, {
      firstName: editedUserData.Firstname || information.information.firstName,
      lastName: editedUserData.Lastname || information.information.lastName,
      phoneNumber:
        editedUserData.PhoneNumber || information.information.phoneNumber,
    });

    setUserData(editedUserData);
    setError("");
  };

  return (
    <Card>
      <CardContent>
        <div className="container">
          <div className="inner-card2">
            <h3>Edit User Details</h3>
            <div className="image-container">
              {/* <img className="user-image" src={user} alt="user" /> */}
            </div>

            {error && <div className="error">{error}</div>}
            <div className="form-group">
              <label>First Name:</label>
              <input
                type="text"
                name="Firstname"
                defaultValue={information.information.firstName}
                onChange={handleInputChange}
              />
            </div>
            <div className="form-group">
              <label>Last Name:</label>
              <input
                type="text"
                name="Lastname"
                defaultValue={information.information.lastName}
                onChange={handleInputChange}
              />
            </div>
            <div className="form-group">
              <label>Phone Number:</label>
              <input
                type="text"
                name="PhoneNumber"
                defaultValue={information.information.phoneNumber}
                onChange={handleInputChange}
              />
            </div>
            <div className="form-group">
              <label>Email:</label>
              <input
                type="text"
                name="Email"
                defaultValue={information.information.email}
                readOnly
                disabled
              />
            </div>

            <button
              className="button"
              disabled={!isDirty}
              onClick={handleUpdate}
            >
              Update
            </button>
          </div>
        </div>
      </CardContent>
    </Card>
  );
}

export default CardUser;
