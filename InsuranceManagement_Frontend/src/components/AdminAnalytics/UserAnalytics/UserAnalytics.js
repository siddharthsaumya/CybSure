import React, { useState, useEffect } from 'react';
import axios from 'axios'; // Assuming you're using Axios for HTTP requests
import { PieChart, Pie, Tooltip, ResponsiveContainer, Cell } from 'recharts';
import './UserAnalytics.css';
import { baseURL } from '../../../Server';
import styles from '../AdminAnalytics.module.scss';

export default function UserAnalytics() {
  const [userData, setUserData] = useState([]);

  useEffect(() => {
    const fetchData = async () => {
      try {
        const response = await axios.get(`${baseURL}/user/users`);
        console.log("Fetched data:", response.data); 
        setUserData(response.data);
      } catch (error) {
        console.error('Error fetching user data:', error);
      }
    };

    fetchData(); 
  }, []);

  const totalUsers = userData.length || 0; 
  const totalClaimants = userData.filter(Users => Users.roleName === 'Claimant').length;
  const totalInsurers = userData.filter(users => users.roleName === 'Agent').length;

  const pieChartData = [
    { name: 'Claimants', value: totalClaimants },
    { name: 'Agents', value: totalInsurers }
  ];

  const COLORS = ['#BC7FCD', '#FFCDEA'];

  const renderCustomizedLabel = ({ cx, cy, midAngle, innerRadius, outerRadius, percent }) => {
    const RADIAN = Math.PI / 180;
    const radius = 25 + innerRadius + (outerRadius - innerRadius);
    const x = cx + radius * Math.cos(-midAngle * RADIAN);
    const y = cy + radius * Math.sin(-midAngle * RADIAN);

    return (
      <text x={x} y={y} fill="white" textAnchor={x > cx ? 'start' : 'end'} dominantBaseline="central">
        {`${(percent * 100).toFixed(0)}%`}
      </text>
    );
  };

  return (
    <>
      <h1 className={styles.title}>User Analytics</h1>
      <div className={styles.secondaryTitle}>Total Users: {totalUsers}</div>

      <div className={styles.chartContainer} style={{width:"50%"}}>
      <ResponsiveContainer width="100%" height={400}>
        <PieChart>
          <Pie
            dataKey="value"
            data={pieChartData}
            cx="50%"
            cy="50%"
            outerRadius={120}
            labelLine={false}
            label={renderCustomizedLabel}
          >
            {pieChartData.map((entry, index) => (
              <Cell key={`cell-${index}`} fill={COLORS[index % COLORS.length]} />
            ))}
          </Pie>
          <Tooltip />
        </PieChart>
      </ResponsiveContainer>
      </div>
    </>
  );
}
