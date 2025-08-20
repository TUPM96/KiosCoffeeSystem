import Head from "next/head";
import { Typography, Row, Col, Card } from "antd";
import DashboardLayout from "../components/DashboardLayout";

const { Title, Paragraph } = Typography;

export default function Home() {
  return (
    <>
      <Head>
        <title>Kios Dashboard</title>
        <meta name="description" content="Kios Admin Dashboard" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link rel="icon" href="/favicon.ico" />
      </Head>
      <DashboardLayout>
        <Title level={2}>Welcome to Kios Dashboard</Title>
        <Paragraph>
          Use the side navigation to manage Admins, Assistants, Branches, City, Containers, Clients, Drivers, Jobs, Job Stops, Load, Lorry, and Trip.
        </Paragraph>
        <Row gutter={[16, 16]}>
          {[
            { title: "Admins", desc: "Manage admin users", href: "/admins" },
            { title: "Branches", desc: "Manage branches", href: "/branches" },
            { title: "City", desc: "Manage cities", href: "/city" },
          ].map((item) => (
            <Col xs={24} sm={12} md={8} lg={6} key={item.title}>
              <a href={item.href} style={{ textDecoration: "none" }}>
                <Card hoverable title={item.title} style={{ marginBottom: 16 }}>
                  {item.desc}
                </Card>
              </a>
            </Col>
          ))}
        </Row>
      </DashboardLayout>
    </>
  );
}
